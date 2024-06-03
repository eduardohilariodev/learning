/* ----------------------------------- SPY ---------------------------------- */
test("should spy on a method of an object", () => {
  const video = {
    play() {
      return true;
    },
  };

  /**
   * @function spyOn tracks calls of the callback function
   */
  const spy = jest.spyOn(video, "play");
  video.play();

  expect(spy).toHaveBeenCalled();

  /**
   * @function mockRestore is use to restore the original implementation of the
   * callback function, the one that has been spied on.
   */
  spy.mockRestore();
});
