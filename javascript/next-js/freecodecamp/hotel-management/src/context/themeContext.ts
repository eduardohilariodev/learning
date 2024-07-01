import type { Dispatch, SetStateAction } from "react";
import { createContext } from "react";

interface ThemeContextType {
  darkTheme: boolean;
  setDarkTheme: Dispatch<SetStateAction<boolean>>;
}

const ThemeContext = createContext<ThemeContextType>({
  darkTheme: false,
  setDarkTheme: () => null,
});

export default ThemeContext;
