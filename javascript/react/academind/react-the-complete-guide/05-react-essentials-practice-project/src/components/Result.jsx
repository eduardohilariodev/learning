import { formatter } from "../util/investment";

export default function Result({ results, userInput }) {
  function getInvestedCapital({
    annualInvestment = 0,
    initialInvestment = 0,
    year = 0,
  }) {
    initialInvestment = Number(initialInvestment);
    annualInvestment = Number(annualInvestment);
    const investedCapital = initialInvestment + annualInvestment * year;
    return formatter.format(investedCapital);
  }

  function getTotalInterest({ year }) {
    // let hasAllUserInputs = true;
    // for (const key in userInput) {
    //   if (!userInput[key]) {
    //     hasAllUserInputs = false;
    //     return;
    //   }
    // }
    let totalInterest = 0;

    for (let index = 0; index < year; index++) {
      totalInterest += Number(results[index].interest);
    }

    return formatter.format(totalInterest);
  }

  return (
    <table id="result">
      <thead>
        <tr>
          <th scope="col">Year</th>
          <th scope="col">Investment Value</th>
          <th scope="col">Interest (Year)</th>
          <th scope="col">Total Interest</th>
          <th scope="col">Invested Capital</th>
        </tr>
      </thead>
      <tbody>
        {results.map((data) => (
          <tr key={data.year}>
            <td>{data.year}</td>
            <td>{formatter.format(data.valueEndOfYear ?? 0)}</td>
            <td>{formatter.format(data.interest ?? 0)}</td>
            <td>{getTotalInterest({ year: data.year })}</td>
            <td>
              {getInvestedCapital({
                annualInvestment: data.annualInvestment,
                initialInvestment: userInput.initialInvestment,
                year: data.year,
              })}
            </td>
          </tr>
        ))}
      </tbody>
    </table>
  );
}
