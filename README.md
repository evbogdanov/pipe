# Pipe |>

Pipe is a kind of Elixir pipe operator implemented in Erlang. Pipe heavily relies on parse transform. It is an experiment made primarily for fun. You should not use this in production.

### What does it look like?

Without Pipe:
```erlang
AtomToUpper = list_to_atom(string:to_upper(atom_to_list('pipe me'))).
```

With Pipe:
```erlang
AtomToUpper = ['pipe me',
               '|>',
               atom_to_list,
               {string, to_upper},
               list_to_atom].
```

Without Pipe:
```erlang
X1 = 1.
X2 = (fun(X) -> X + 1 end)(X1).
X3 = (fun(X) -> X * 2 end)(X2).
X4 = (fun(X) -> X / 3 end)(X3).
```

With Pipe:
```erlang
X = [1,
     '|>',
     fun(X) -> X + 1 end,
     fun(X) -> X * 2 end,
     fun(X) -> X / 3 end],
```

## Building
```
make
```

## Running tests
```
make test
```
