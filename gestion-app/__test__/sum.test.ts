function sum(a: number, b: number): number {
  return a + b;
}

test('sumar correctamente', () => {
  expect(sum(2, 3)).toBe(5);
});
