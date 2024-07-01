"use client";

import ThemeContext from "@/context/themeContext";
import Link from "next/link";
import { useContext } from "react";
import { FaUserCircle } from "react-icons/fa";
import { MdDarkMode, MdOutlineLightMode } from "react-icons/md";

const Header = () => {
  const { darkTheme, setDarkTheme } = useContext(ThemeContext);

  return (
    <header className="container mx-auto flex flex-wrap items-center justify-center px-4 py-10 text-xl md:flex-nowrap">
      <div className="md:2/3 flex w-full items-center">
        <Link href="/" className="font-black text-tertiary-light">
          Hotelzz
        </Link>
        <ul className="ml-5 flex items-center">
          <li className="flex items-center">
            <Link href={"/auth"}>
              <FaUserCircle />
            </Link>
          </li>
          <li className="ml-2 cursor-pointer">
            {darkTheme ? (
              <MdOutlineLightMode
                onClick={() => {
                  setDarkTheme(false);
                  localStorage.removeItem("hotel-theme");
                }}
              />
            ) : (
              <MdDarkMode
                onClick={() => {
                  setDarkTheme(true);
                  localStorage.setItem("hotel-theme", "true");
                }}
              />
            )}
          </li>
        </ul>
      </div>
      <ul className="mt-4 flex w-full items-center justify-between md:w-1/3">
        <li className="transition-all duration-500 hover:-translate-y-2">
          <Link href="/">Home</Link>
        </li>
        <li className="transition-all duration-500 hover:-translate-y-2">
          <Link href="/">Rooms</Link>
        </li>
        <li className="transition-all duration-500 hover:-translate-y-2">
          <Link href="/">Contact</Link>
        </li>
      </ul>
    </header>
  );
};

export default Header;
