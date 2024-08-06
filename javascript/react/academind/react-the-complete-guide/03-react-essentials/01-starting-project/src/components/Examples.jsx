import { useState } from "react";
import TabButton from "./TabButton";
import { EXAMPLES } from "../data";
import Section from "./Section";

const Examples = () => {
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
    <Section
      title="Examples"
      id="examples"
    >
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
      {tabContent}
    </Section>
  );
};

export default Examples;
