import CoreConcept from "./components/CoreConcepts";
import Header from "./components/Header";
import TabButton from "./components/TabButton";
import { CORE_CONCEPTS } from "./data";

function App() {
  let tabContent = "Please click a button";

  const handleSelect = (selectedButton) => {
    console.debug(selectedButton);
    tabContent = selectedButton;
  };

  console.debug("App component rendering");

  return (
    <div>
      <Header />
      <main>
        <section id="core-concepts">
          <h2>Core Concepts</h2>
          <ul>
            <CoreConcept {...CORE_CONCEPTS[0]} />
            <CoreConcept {...CORE_CONCEPTS[1]} />
            <CoreConcept {...CORE_CONCEPTS[2]} />
            <CoreConcept {...CORE_CONCEPTS[3]} />
          </ul>
        </section>
        <section id="examples">
          <menu>
            <TabButton onSelect={() => handleSelect("components")}>
              Components
            </TabButton>
            <TabButton onSelect={() => handleSelect("jsx")}>JSX</TabButton>
            <TabButton onSelect={() => handleSelect("props")}>Props</TabButton>
            <TabButton onSelect={() => handleSelect("state")}>State</TabButton>
          </menu>
          {tabContent}
        </section>
      </main>
    </div>
  );
}
export default App;
