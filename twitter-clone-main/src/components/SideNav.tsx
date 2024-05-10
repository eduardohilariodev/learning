import { signIn, signOut, useSession } from "next-auth/react";
import Link from "next/link";

export function SideNav() {
  const session = useSession();
  const user = session.data?.user;

  return (
    <nav className="sticky top-0 px-2 py-4">
      <ul className="flex flex-col items-start gap-2 whitespace-nowrap">
        <li>
          <Link href="/">Home</Link>
        </li>
        <li>
          {user != null && <Link href={`/profiles/${user.id}`}>Profile</Link>}
        </li>
        <li>
          {user == null ? (
            <button onClick={() => void signIn()}>Log In</button>
          ) : (
            <button onClick={() => void signOut()}>Log Out</button>
          )}
        </li>
      </ul>
    </nav>
  );
}
