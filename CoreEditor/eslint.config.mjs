import globals from 'globals';
import parser from '@typescript-eslint/parser';
import js from '@eslint/js';
import ts from 'typescript-eslint';
import compat from 'eslint-plugin-compat';
import promise from 'eslint-plugin-promise';

export default [
  {
    ignores: [
      '.yarn',
      'dist/*',
      'src/@vendor/*',
    ],
  },
  js.configs.recommended,
  ...ts.configs.recommended,
  compat.configs['flat/recommended'],
  promise.configs['flat/recommended'],
  {
    languageOptions: {
      globals: {
        ...globals.browser,
      },
      parser,
      parserOptions: {
        project: [
          'tsconfig.json',
        ],
      },
    },
    rules: {
      'no-case-declarations': 'error',
      'no-prototype-builtins': 'error',
      'array-bracket-spacing': ['error', 'never'],
      'eol-last': 'error',
      'no-new-wrappers': 'error',
      'no-array-constructor': 'error',

      'no-restricted-syntax': [
        'error',
        {
          'selector': 'TSEnumDeclaration[const=true]',
          'message': 'Always use enum and not const enum. TypeScript enums already cannot be mutated; const enum is a separate language feature related to optimization that makes the enum invisible to JavaScript users of the module.',
        },
        {
          'selector': 'ArrowFunctionExpression[parent.type=\'PropertyDefinition\'][parent.parent.type=\'ClassBody\']',
          'message': 'Arrow functions are not allowed in class properties. Define as a method instead.',
        },
      ],

      '@typescript-eslint/no-non-null-assertion': 'error',
      '@typescript-eslint/no-explicit-any': 'error',
      '@typescript-eslint/member-delimiter-style': 'error',
      '@typescript-eslint/no-unnecessary-condition': 'error',
      '@typescript-eslint/no-unnecessary-type-arguments': 'error',
      '@typescript-eslint/no-unnecessary-type-constraint': 'error',
      '@typescript-eslint/no-unsafe-argument': 'error',
      '@typescript-eslint/prefer-optional-chain': 'error',
      '@typescript-eslint/prefer-readonly': 'error',
      '@typescript-eslint/strict-boolean-expressions': 'error',
      '@typescript-eslint/switch-exhaustiveness-check': 'error',
      '@typescript-eslint/type-annotation-spacing': 'error',
      '@typescript-eslint/explicit-member-accessibility': ['error', { accessibility: 'no-public' }],
      '@typescript-eslint/consistent-type-exports': ['error', { fixMixedExportsWithInlineTypeSpecifier: true }],
      '@typescript-eslint/class-literal-property-style': 'error',

      'brace-style': 'off',
      '@typescript-eslint/brace-style': ['error', '1tbs', { 'allowSingleLine': true }],
      'comma-dangle': 'off',
      '@typescript-eslint/comma-dangle': ['error', 'always-multiline'],
      'comma-spacing': 'off',
      '@typescript-eslint/comma-spacing': 'error',
      'dot-notation': 'off',
      '@typescript-eslint/dot-notation': 'error',
      'func-call-spacing': 'off',
      '@typescript-eslint/func-call-spacing': 'error',
      'indent': 'off',
      '@typescript-eslint/indent': ['error', 2],
      'keyword-spacing': 'off',
      '@typescript-eslint/keyword-spacing': 'error',
      'no-dupe-class-members': 'off',
      '@typescript-eslint/no-dupe-class-members': 'error',
      'no-extra-parens': 'off',
      '@typescript-eslint/no-extra-parens': ['error', 'functions'],
      'no-invalid-this': 'off',
      '@typescript-eslint/no-invalid-this': 'error',
      'no-redeclare': 'off',
      '@typescript-eslint/no-redeclare': 'error',
      'no-throw-literal': 'off',
      '@typescript-eslint/no-throw-literal': 'error',
      'no-unused-expressions': 'off',
      '@typescript-eslint/no-unused-expressions': 'error',
      'no-unused-vars': 'off',
      '@typescript-eslint/no-unused-vars': ['error', { 'ignoreRestSiblings': true, 'argsIgnorePattern': '^_' }],
      'object-curly-spacing': 'off',
      '@typescript-eslint/object-curly-spacing': ['error', 'always'],
      'quotes': 'off',
      '@typescript-eslint/quotes': [2, 'single', { 'avoidEscape': true }],
      'no-return-await': 'off',
      '@typescript-eslint/return-await': 'error',
      'semi': 'off',
      '@typescript-eslint/semi': 'error',

      'promise/prefer-await-to-then': 'error',
    },
  },
];
