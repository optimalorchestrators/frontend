const nextJest = require('next/jest');

const createJestConfig = nextJest({
  dir: './',
});

const customJestConfig = {
  moduleDirectories: ['node_modules', '<rootDir>/'],
  testEnvironment: 'jest-environment-jsdom',
  collectCoverage: true, // Ajoute la collecte de couverture de code
  collectCoverageFrom: ['<rootDir>/components/**/*.js', '<rootDir>/pages/**/*.js'], // Spécifie les fichiers pour la couverture
  coverageDirectory: '<rootDir>/coverage/', // Répertoire de sortie pour la couverture
  transform: {
    '^.+\\.css$': 'jest-transform-css', // Transforme les fichiers CSS
    '^.+\\.(jpg|jpeg|png|gif|webp|svg)$': 'jest-transform-file', // Transforme les fichiers d'image
  },
};

module.exports = createJestConfig(customJestConfig);
