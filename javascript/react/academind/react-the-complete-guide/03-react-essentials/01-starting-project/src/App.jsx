import { useState } from "react";
import CoreConcept from "./components/CoreConcepts";
import Header from "./components/Header";
import TabButton from "./components/TabButton";
import { CORE_CONCEPTS, EXAMPLES } from "./data";

function App() {
  const topics = {
    COMPONENTS: "components",
    STATE: "state",
    JSX: "jsx",
    PROPS: "props",
  };
  const [selectedTopic, setSelectedTopic] = useState();

  const handleSelect = (selectedButton) => {
    setSelectedTopic(selectedButton);
    console.debug(selectedTopic);
  };

  console.debug("App component rendering");

  const tabContent = selectedTopic ? (
    <div id="tab-content">
      <h3>{EXAMPLES[selectedTopic].title}</h3>
      <p>{EXAMPLES[selectedTopic].description}</p>
      <pre>
        <code>{EXAMPLES[selectedTopic].code}</code>
      </pre>
    </div>
  ) : (
    <p>Please select a topic.</p>
  );

  return (
    <div>
      <Header />
      <main>
        <section id="core-concepts">
          <h2>Core Concepts</h2>
          <ul>
            {CORE_CONCEPTS.map((item) => (
              <CoreConcept
                key={item.title}
                {...item}
              />
            ))}
          </ul>
        </section>
        <section id="examples">
          <menu>
            <TabButton
              isSelected={selectedTopic === topics.COMPONENTS}
              onSelect={() => handleSelect(topics.COMPONENTS)}
            >
              Components
            </TabButton>

            <TabButton
              isSelected={selectedTopic === topics.JSX}
              onSelect={() => handleSelect(topics.JSX)}
            >
              JSX
            </TabButton>
            <TabButton
              isSelected={selectedTopic === topics.PROPS}
              onSelect={() => handleSelect(topics.PROPS)}
            >
              Props
            </TabButton>
            <TabButton
              isSelected={selectedTopic === topics.STATE}
              onSelect={() => handleSelect(topics.STATE)}
            >
              State
            </TabButton>
          </menu>
        </section>
        {tabContent}
      </main>
    </div>
  );
}
export default App;
