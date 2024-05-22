# tdd_clean_architecture_course

# SOLID

- Model shields the domain layer from the influence of remote APIs and JSONs


# Conventions

## Naming

### Files

- `snake_case` for files and folders

  - ```
    lib
    ├── core
    │ ├── errors
    | | ├── exceptions.dart
    ...
    test
    ├── core
    │ ├── errors
    | | ├── exceptions_test.dart
    ```

- `PascalCase` for classes and enums

  - ```dart
    class InvalidEmailException implements Exception {}
    ```

- `camelCase` for variables and functions

  - ```dart
    void validateEmail(String email) {
      if (!email.contains('@')) {
        throw InvalidEmailException();
      }
    }
    ```

## Folder structure

test

- `lib` and `test` folders mirror each other

  - ```
    lib
    ├── core
    │ ├── errors
    | | ├── exceptions.dart
    ...
    test
    ├── core
    │ ├── errors
    | | ├── exceptions_test.dart *
    ```

  - Test files are named `<file_name>_test.dart`
    > `exceptions.dart` -> `exceptions_test.dart`

## Testing

### Naming

| Methods | Description                                                           | Casing    |
| ------- | --------------------------------------------------------------------- | --------- |
| `test`  | _should `<expected behavior>` when `<given circumstance>` is `<met>`_ | lowercase |

### Practices

### JSON

- When testing with JSON, use fixtures

  - ```dart
 json = jsonDecode(fixture('trivia.json'));
    ```
- Strive to have the tests as close to real data as possible
- On the refactor phase, always check if the tests are still passing
- Only write as little code as possible to make the tests pass
- [Delivering fast testing strategies](https://www.infoq.com/articles/delivering-fast-testing-strategies/)
  > Every test requires effort to be developed and maintained but not every test adds value. It is better to not write a test at all than to write a bad test.

- [The Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
  > Nothing in an inner circle can know anything at all about something in an outer circle. In particular, the name of something declared in an outer circle must not be mentioned by the code in the an inner circle. That includes, functions, classes. variables, or any other named software entity.
