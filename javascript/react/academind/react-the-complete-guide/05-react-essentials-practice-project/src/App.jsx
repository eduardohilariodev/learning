import Result from "./components/Result";
import UserInput from "./components/UserInput";
import Header from "./components/Header";
import { calculateInvestmentResults } from "./util/investment";
import { useEffect, useState } from "react";

const INITIAL_USER_INPUT = {
  initialInvestment: 0,
  annualInvestment: 0,
  expectedReturn: 0,
  duration: 0,
};

const INITIAL_RESULTS = [
  {
    year: 0,
    interest: 0,
    valueEndOfYear: 0,
    annualInvestment: 0,
  },
];

function App() {
  const [userInput, setUserInput] = useState(INITIAL_USER_INPUT);
  const [hasUserInput, setHasUserInput] = useState(false);

  const [results, setResults] = useState(INITIAL_RESULTS);

  useEffect(() => {
    const calculatedResults = calculateInvestmentResults(userInput);
    setResults(calculatedResults);

    let isUserInputValid = true;
    for (const key in userInput) {
      if (!userInput[key] || Number(userInput.duration) < 0) {
        isUserInputValid = false;
        break;
      }
    }
    setHasUserInput(isUserInputValid);
  }, [userInput]);

  function handleChangeUserInput(value) {
    setUserInput((prevState) => ({ ...prevState, ...value }));
  }

  return (
    <>
      <Header />
      <UserInput onChange={handleChangeUserInput} />

      {hasUserInput && (
        <Result
          results={results}
          userInput={userInput}
        />
      )}
    </>
  );
}

export default App;
