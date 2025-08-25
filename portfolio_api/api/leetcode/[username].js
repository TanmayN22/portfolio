export default async function handler(req, res) {
  // CORS headers
  res.setHeader('Access-Control-Allow-Credentials', true);
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    res.status(200).end();
    return;
  }

  if (req.method !== 'GET') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { username } = req.query;
    if (!username) {
      return res.status(400).json({ error: 'Username is required' });
    }

    // Try multiple LeetCode APIs
    const apis = [
      `https://leetcode-stats-api.herokuapp.com/${username}`,
      `https://alfa-leetcode-api.onrender.com/${username}/solved`
    ];

    for (const apiUrl of apis) {
      try {
        const controller = new AbortController();
        const timeoutId = setTimeout(() => controller.abort(), 10000);
        const response = await fetch(apiUrl, {
          signal: controller.signal
        });
        clearTimeout(timeoutId);

        if (response.ok) {
          const data = await response.json();
          return res.status(200).json(data);
        }
      } catch (err) {
        console.log(`Failed API: ${apiUrl}`, err.message);
        continue;
      }
    }

    return res.status(500).json({
      error: 'All LeetCode APIs failed'
    });
  } catch (error) {
    console.error('LeetCode API Error:', error);
    return res.status(500).json({
      error: 'Failed to fetch LeetCode stats',
      message: error.message
    });
  }
}
