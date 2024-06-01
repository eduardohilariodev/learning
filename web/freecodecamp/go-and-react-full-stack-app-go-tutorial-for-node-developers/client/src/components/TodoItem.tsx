import { Badge, Box, Flex, Spinner, Text } from "@chakra-ui/react";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { FaCheckCircle } from "react-icons/fa";
import { MdDelete } from "react-icons/md";
import { BASE_URL } from "../contants";
import { Todo } from "./TodoList";

const TodoItem = ({ todo }: { todo: Todo }) => {
  const queryClient = useQueryClient();
  const { mutate: updateTodo, isPending: isUpdating } = useMutation({
    mutationKey: ["updateTodo"],
    mutationFn: async () => {
      if (todo.completed) {
        return alert("Todo is already completed");
      }
      try {
        const response = await fetch(`${BASE_URL}/todos/${todo._id}`, {
          method: "PATCH",
        });
        const data = await response.json();

        if (!response.ok) {
          throw new Error(data.error || "Something went wrong");
        }

        return data;
      } catch (error) {
        console.error(error);
      }
    },
    /**
     * What's the purpose of `queryClient.invalidateQueries` on `onSuccess`
     * here?
     *
     * To invalidate queries.
     *
     * What this means?
     *
     * It means that the previous `listTodos` query can be considered invalid,
     * with out of date information.
     *
     * Because `mutationKey` of `TodoList` is set to `todos`, when can as
     * Tanstack to refetch that query once this one succeedes.
     */
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["todos"] });
    },
  });

  const { mutate: deleteTodo, isPending: isDeleting } = useMutation({
    mutationKey: ["deleteTodo"],
    mutationFn: async () => {
      try {
        const response = await fetch(`${BASE_URL}/todos/${todo._id}`, {
          method: "DELETE",
        });
        const data = await response.json();

        if (!response.ok) {
          throw new Error(data.error || "Something went wrong");
        }

        return data;
      } catch (error) {
        console.error(error);
      }
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["todos"] });
    },
  });

  return (
    <Flex gap={2} alignItems={"center"}>
      <Flex
        flex={1}
        alignItems={"center"}
        border={"1px"}
        borderColor={"gray.600"}
        p={2}
        borderRadius={"lg"}
        justifyContent={"space-between"}
      >
        <Text
          color={todo.completed ? "green.200" : "yellow.100"}
          textDecoration={todo.completed ? "line-through" : "none"}
        >
          {todo.body}
        </Text>
        {todo.completed ? (
          <Badge ml="1" colorScheme="green">
            Done
          </Badge>
        ) : (
          <Badge ml="1" colorScheme="yellow">
            In Progress
          </Badge>
        )}
      </Flex>
      <Flex gap={2} alignItems={"center"}>
        <Box
          color={"green.500"}
          cursor={"pointer"}
          onClick={() => updateTodo()}
        >
          {isUpdating ? <Spinner size={"sm"} /> : <FaCheckCircle size={20} />}
        </Box>
        <Box color={"red.500"} cursor={"pointer"} onClick={() => deleteTodo()}>
          {isDeleting ? <Spinner size={"sm"} /> : <MdDelete size={25} />}
        </Box>
      </Flex>
    </Flex>
  );
};
export default TodoItem;
