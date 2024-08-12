import { useState } from "react";
import TabButton from "./TabButton";
import { EXAMPLES } from "../data";
import Section from "./Section";
import Tabs from "./Tabs";

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
      <Tabs
        buttons={
          <>
            <TabButton
              isSelected={selectedTopic === topics.COMPONENTS}
              onClick={() => handleSelect(topics.COMPONENTS)}
            >
              Components
            </TabButton>
            <TabButton
              isSelected={selectedTopic === topics.JSX}
              onClick={() => handleSelect(topics.JSX)}
            >
              JSX
            </TabButton>
            <TabButton
              isSelected={selectedTopic === topics.PROPS}
              onClick={() => handleSelect(topics.PROPS)}
            >
              Props
            </TabButton>
            <TabButton
              isSelected={selectedTopic === topics.STATE}
              onClick={() => handleSelect(topics.STATE)}
            >
              State
            </TabButton>
          </>
        }
      >
        {tabContent}
      </Tabs>
    </Section>
  );
};

export default Examples;
