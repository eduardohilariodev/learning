import type { ChangeEvent } from "react";
import { useState } from "react";
import { AiFillGithub } from "react-icons/ai";
import { FcGoogle } from "react-icons/fc";

const defaultFormData = {
  email: "",
  password: "",
  name: "",
};
const Auth = () => {
  const inputStyles =
    "border dark:bg-black border-gray-300 sm:text-sm text-black rounded-lg block w-full p-2.5 focus:outline-none";

  const [formData, setFormData] = useState(defaultFormData);

  const handleInputChange = (event: ChangeEvent<HTMLInputElement>) => {};
  return (
    <section className="container mx-auto">
      <div className="mx-auto w-80 space-y-4 p-6 sm:p-8 md:w-[70%] md:space-y-4">
        <div className="mb-8 flex flex-col items-center justify-between md:flex-row">
          <h1 className="text-xl font-bold leading-tight tracking-tight md:text-2xl">
            Create an account
          </h1>
          <p>OR</p>
          <span className="inline-flex items-center">
            <AiFillGithub className="mr-3 cursor-pointer text-4xl text-black dark:text-white" />
            <span>|</span>
            <FcGoogle className="ml-3 cursor-pointer text-4xl" />
          </span>
        </div>
        <form action="" className="space-y-4 md:space-y-6">
          <input
            type="text"
            name="name"
            placeholder="John Doe"
            required
            className={inputStyles}
            value={formData.name}
            onChange={handleInputChange}
          />
          <input
            type="email"
            name="email"
            placeholder="name@company.com"
            required
            className={inputStyles}
            value={formData.email}
            onChange={handleInputChange}
          />
          <input
            type="password"
            name="password"
            placeholder="password"
            required
            minLength={6}
            className={inputStyles}
            value={formData.password}
            onChange={handleInputChange}
          />
          <button
            type="submit"
            className="w-full rounded-lg bg-tertiary-dark px-5 py-2.5 text-center text-sm font-medium focus:outline-none"
          >
            Sign Up
          </button>
          <button type="submit" className="text-blue-500 underline">
            Login
          </button>
        </form>
      </div>
    </section>
  );
};

export default Auth;
