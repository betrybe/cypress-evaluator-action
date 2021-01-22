const fs = require('fs')

const CORRECT_ANSWER_GRADE = 3;
const WRONG_ANSWER_GRADE = 1;

const githubUsername = process.env.INPUT_PR_AUTHOR_USERNAME || 'no_actor';
const githubRepositoryName = process.env.GITHUB_REPOSITORY || 'no_repository';

// https://nodejs.org/en/knowledge/command-line/how-to-parse-command-line-arguments/
const evaluationFileContent = fs.readFileSync(process.argv[2]);
const testData = JSON.parse(evaluationFileContent);

const leafSuites = (suites, leaves = []) => {
  suites.forEach((suite) => {
    if (suite.suites.length === 0) {
      leaves.push(suite);
      return;
    }

    leafSuites(suite.suites, leaves);
  });

  return leaves.flat();
};

const evaluationsByRequirements =
  leafSuites(testData.results).reduce(
    (acc, { title, tests, passes }) => {
      const allUnitTestsPassed = tests.length === passes.length;
      acc[title] = allUnitTestsPassed;
      return acc;
    },
    {}
  );

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
