import { Flex, Spinner, Stack, Text } from "@chakra-ui/react";
import { useQuery } from "@tanstack/react-query";
import { BASE_URL } from "../contants";
import TodoItem from "./TodoItem";

export type Todo = {
  _id: number;
  body: string;
  completed: boolean;
};

const TodoList = () => {
  const { data: todos, isLoading } = useQuery<Todo[]>({
    /**
     *
     *
     * `queryKey` is an identifier for this query. In case of refetching, it'll
     * use this query key to do it.
     */
    queryKey: ["todos"],
    queryFn: async () => {
      try {
        const response = await fetch(BASE_URL + "/todos");
        const data = await response.json();

        if (!response.ok) {
          throw new Error(data.error || "Something wen wrong");
        }

        return data || [];
      } catch (error) {
        console.error(error);
      }
    },
  });
  return (
    <>
      <Text
        bgClip="text"
        fontSize={"4xl"}
        bgGradient="linear(to-l, #0b85f8, #00ffff)"
        textTransform={"uppercase"}
        fontWeight={"bold"}
        textAlign={"center"}
        my={2}
      >
        Today's Tasks
      </Text>
      {isLoading && (
        <Flex justifyContent={"center"} my={4}>
          <Spinner size={"xl"} />
        </Flex>
      )}
      {!isLoading && todos?.length === 0 && (
        <Stack alignItems={"center"} gap="3">
          <Text fontSize={"xl"} textAlign={"center"} color={"gray.500"}>
            All tasks completed! 🤞
          </Text>
          <img src="/go.png" alt="Go logo" width={70} height={70} />
        </Stack>
      )}
      <Stack gap={3}>
        {todos?.map((todo) => (
          <TodoItem key={todo._id} todo={todo} />
        ))}
      </Stack>
    </>
  );
};
export default TodoList;
