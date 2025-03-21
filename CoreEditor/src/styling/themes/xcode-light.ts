import { EditorColors, EditorTheme } from '../types';
import { buildTheme, buildHighlight, tags } from '../builder';
import { lightBase as base } from './colors';

const palette = {
  text: '#000000',
  brown: '#815f03',
};

const colors: EditorColors = {
  accent: '#0b4f79',
  text: palette.text,
  comment: '#5d6c79',
  background: '#ffffff',
  caret: palette.text,
  selection: '#a4cdff',
  activeLine: '#e8f2ff',
  matchingBracket: '#326d7440',
  lineNumber: '#a6a6a6',
  searchMatch: '#e4e4e4',
  selectionHighlight: '#e9eef9',
  visibleSpace: '#cccccc',
  lighterBackground: '#cccccc4c',
};

function theme() {
  return buildTheme(colors);
}

function highlight() {
  // Order matters, don't change it unless you fully understand how it works
  return buildHighlight(colors, [
    { tag: [tags.keyword, tags.modifier, tags.operator, tags.operatorKeyword, tags.self], color: '#9b2393' },
    { tag: [tags.literal, tags.inserted], color: base.green },
    { tag: [tags.deleted, tags.macroName], color: base.red },
    { tag: [tags.className, tags.definition(tags.propertyName), tags.definition(tags.typeName)], color: '#1c464a' },
    { tag: [tags.function(tags.variableName), tags.function(tags.propertyName)], color: '#6c36a9' },
    { tag: [tags.meta, tags.comment], color: colors.comment, fontStyle: 'italic' },
    { tag: [tags.link, tags.escape, tags.string, tags.regexp, tags.special(tags.string)], color: '#c41a16' },
    { tag: [tags.linkMark, tags.listMark], color: '#643820' },
    { tag: tags.url, color: '#0f68a0' },
    { tag: tags.propertyName, color: colors.text },
    { tag: tags.tagName, color: colors.accent },
    { tag: tags.attributeName, color: palette.brown },
    { tag: tags.definition(tags.variableName), color: '#326d74' },
    { tag: [tags.quote, tags.quoteMark], color: '#4a5560', fontStyle: 'italic' },
    { tag: [tags.atom, tags.bool, tags.number], color: '#1c00cf' },
    { tag: tags.emphasis, color: palette.brown, fontStyle: 'italic' },
    { tag: tags.strong, color: '#3900a0', fontWeight: 'bolder' },
  ]);
}

export default function XcodeLight(): EditorTheme {
  return {
    colors,
    extension: [theme(), highlight()],
  };
}
