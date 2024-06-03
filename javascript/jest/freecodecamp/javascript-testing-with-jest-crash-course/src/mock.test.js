/* Example
const mockCallbackFn = jest.fn((x) => 42 + x);
mockCallbackFn(0);
mockCallbackFn(1);
*/

/* ---------------------------------- MOCK ---------------------------------- */
test("should work with mock implementation", () => {
  const mockFn = jest.fn((x) => 42 + x);
  expect(mockFn(1)).toBe(43);
  expect(mockFn).toHaveBeenCalledWith(1);
});
