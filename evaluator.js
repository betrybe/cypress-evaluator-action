const fs = require('fs')

const CORRECT_ANSWER_GRADE = 3;
const WRONG_ANSWER_GRADE = 1;

const githubUsername = process.env.GITHUB_ACTOR || 'no_actor';
const githubRepositoryName = process.env.GITHUB_REPOSITORY || 'no_repository';

// https://nodejs.org/en/knowledge/command-line/how-to-parse-command-line-arguments/
const evaluationFileContent = fs.readFileSync(process.argv[2]);
const testData = JSON.parse(evaluationFileContent);

const evaluationsByRequirements =
  testData.results.map((result) => (
    result.suites.map(({ title, tests, passes }) => ({
      title,
      tests,
      passes,
    }))
  )).flat()
    .reduce((acc, { title, tests, passes }) => {
      const allUnitTestsPassed = tests.length === passes.length;
      acc[title] = allUnitTestsPassed;
      return acc;
    }, {});

const requirementsFile = fs.readFileSync(process.argv[3]);
const { requirements } = JSON.parse(requirementsFile);

const evaluations =
  requirements.map(({ description }) => (
    {
      description,
      grade: evaluationsByRequirements[description] ? CORRECT_ANSWER_GRADE : WRONG_ANSWER_GRADE
    }
  ));

fs.writeFileSync(process.argv[4], JSON.stringify({
  github_username: githubUsername,
  github_repository_name: githubRepositoryName,
  evaluations: [...evaluations]
}));

process.exit();
