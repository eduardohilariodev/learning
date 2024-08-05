const TabButton = ({ children }) => {
  const handleClick = () => {
    console.debug("Hello world!");
  };

  return (
    <li>
      <button onClick={handleClick}>{children}</button>
    </li>
  );
};

export default TabButton;
