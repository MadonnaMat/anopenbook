import voca from 'voca';

function linkArray(objs) {
  return objs.map(
    p =>
      `link${voca
        .chain(p)
        .camelCase()
        .capitalize()
        .value()}`,
  );
}

export default linkArray;
