export default async function handler(req, res) {
  // CORS headers
  res.setHeader('Access-Control-Allow-Credentials', true);
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    res.status(200).end();
    return;
  }

  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { username } = req.body;
    if (!username) {
      return res.status(400).json({ error: 'Username is required' });
    }

    const query = `
      query($username: String!) {
        user(login: $username) {
          name
          login
          bio
          location
          followers {
            totalCount
          }
          following {
            totalCount
          }
          repositories(first: 100, ownerAffiliations: OWNER, orderBy: {field: CREATED_AT, direction: DESC}) {
            totalCount
            nodes {
              name
              stargazerCount
              forkCount
              primaryLanguage {
                name
              }
            }
          }
          pullRequests {
            totalCount
          }
          issues {
            totalCount
          }
          contributionsCollection {
            totalCommitContributions
            totalPullRequestContributions
            totalIssueContributions
            totalPullRequestReviewContributions
            totalRepositoriesWithContributedCommits
            contributionCalendar {
              weeks {
                contributionDays {
                  contributionCount
                  date
                }
              }
            }
          }
          repositoriesContributedTo(contributionTypes: [COMMIT, ISSUE, PULL_REQUEST]) {
            totalCount
          }
        }
      }
    `;

    const response = await fetch('https://api.github.com/graphql', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${process.env.GITHUB_TOKEN}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        query: query,
        variables: { username }
      })
    });

    if (!response.ok) {
      throw new Error(`GitHub API error: ${response.status}`);
    }

    const data = await response.json();
    if (data.errors) {
      return res.status(400).json({
        error: 'GraphQL Error',
        details: data.errors
      });
    }

    return res.status(200).json(data.data.user);
  } catch (error) {
    console.error('GitHub API Error:', error);
    return res.status(500).json({
      error: 'Failed to fetch GitHub stats',
      message: error.message
    });
  }
}
