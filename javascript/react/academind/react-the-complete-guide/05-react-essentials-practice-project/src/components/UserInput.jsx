import { useState } from "react";

export default function UserInput({ onChange }) {
  const [initialInvestment, setInitialInvestment] = useState(0);
  const [annualInvestment, setAnnualInvestment] = useState(0);
  const [expectedReturn, setExpectedReturn] = useState(0);
  const [duration, setDuration] = useState(0);

  function handleChangeInitialInvestment(event) {
    const initialInvestment = event.target.value;
    setInitialInvestment(initialInvestment);
    onChange({ initialInvestment });
  }

  function handleChangeAnnualInvestment(event) {
    const annualInvestment = event.target.value;
    setAnnualInvestment(annualInvestment);
    onChange({ annualInvestment });
  }

  function handleChangeExpectedReturn(event) {
    const expectedReturn = event.target.value;
    setExpectedReturn(expectedReturn);
    onChange({ expectedReturn });
  }

  function handleChangeDuration(event) {
    const duration = event.target.value;
    setDuration(duration);
    onChange({ duration });
  }

  return (
    <form id="user-input">
      <div className="input-group">
        <div>
          <label htmlFor="initial-investment">Initial Investment</label>
          <input
            value={initialInvestment}
            onChange={handleChangeInitialInvestment}
            id="initial-investment"
            name="initial-investment"
            type="number"
          />
        </div>
        <div>
          <label htmlFor="annual-investment">Annual Investment</label>
          <input
            value={annualInvestment}
            onChange={handleChangeAnnualInvestment}
            id="annual-investment"
            name="annual-investment"
            type="number"
          />
        </div>
      </div>
      <br />
      <div className="input-group">
        <div>
          <label htmlFor="expected-return">Expected Return</label>
          <input
            value={expectedReturn}
            onChange={handleChangeExpectedReturn}
            id="expected-return"
            name="expected-return"
            type="number"
          />
        </div>
        <div>
          <label htmlFor="duration">Duration</label>
          <input
            value={duration}
            onChange={handleChangeDuration}
            id="duration"
            name="duration"
            type="number"
          />
        </div>
      </div>
    </form>
  );
}
