# Binary Search Tree Interpreter

A command-line interpreter for building and manipulating binary search trees, written in Yacc/Bison and Lex/Flex.

## Overview

This project implements a domain-specific language (DSL) for creating, manipulating, and querying binary search trees. You can construct trees using a prefix notation, perform insertions and deletions, count nodes, search for values, and check tree properties.

## Features

- **Tree Construction**: Build trees using prefix notation with the `NODE` keyword
- **Insertion**: Add values to the tree using `INSERT`
- **Deletion**: Remove values from the tree using `DELETE`
- **Node Counting**: Count total nodes in a tree with `COUNT`
- **Search**: Find a key in the tree using `FIND`
- **Balance Checking**: Verify if a tree is perfectly balanced with `BALANCED`
- **Tree Printing**: Display trees in prefix notation (in-order format)

## Building

### Prerequisites

- `bison` (parser generator)
- `flex` (lexical analyzer generator)
- `gcc` (C compiler)
- macOS or Linux

### Compilation

```bash
cd yacc_bst_interpreter
bison -d tree.y
flex tree.l
gcc -o TREE y.tab.c lex.yy.c -ly -ll
```

Or use the simplified command:

```bash
make
```

(if a Makefile is provided)

## Usage

Run the interpreter interactively:

```bash
./TREE
```

Then enter commands at the prompt. Each command must end with a newline.

## Grammar

### Basic Elements

- **Numbers**: Integer literals (e.g., `5`, `10`, `42`)
- **Lf**: Leaf node (empty/null)
- **Node**: Create a node with structure `Node <left_subtree> <value> <right_subtree>`

### Operations

#### COUNT
Returns the number of nodes in a tree.
```
COUNT (Node (Node Lf 2 Lf) 10 (Node Lf 12 Lf))
```
Output: `3`

#### INSERT
Inserts a value into a tree maintaining BST property.
```
INSERT 5 (Node Lf 10 Lf)
```
Output: `NODE Lf 5 NODE Lf 10 Lf`

#### DELETE
Removes a value from the tree.
```
DELETE 10 (Node Lf 10 Lf)
```

#### FIND
Searches for a key in the tree.
```
FIND 10 (Node (Node Lf 5 Lf) 10 (Node Lf 15 Lf))
```
Output: `True`

#### BALANCED
Checks if the tree is perfectly balanced (both subtrees have equal height).
```
BALANCED (Node (Node Lf 2 Lf) 10 (Node Lf 12 Lf))
```
Output: `True`

## Example Run

```bash
./TREE
```

Then enter the following commands:

```
(Node Lf 10 Lf)
NODE Lf 10 Lf

COUNT (Node (Node Lf 2 Lf) 10 (Node Lf 12 Lf))
3

FIND 12 (Node (Node Lf 2 Lf) 10 (Node Lf 12 Lf))
True

FIND 5 (Node (Node Lf 2 Lf) 10 (Node Lf 12 Lf))
False

BALANCED (Node (Node Lf 2 Lf) 10 (Node Lf 12 Lf))
True

BALANCED (Node (Node Lf 2 Lf) 10 Lf)
False

INSERT 15 (Node Lf 10 Lf)
NODE Lf 10 NODE Lf 15 Lf

DELETE 10 (Node (Node Lf 5 Lf) 10 (Node Lf 15 Lf))
NODE NODE Lf 5 Lf NODE Lf 15 Lf
```

## Tree Representation

Trees are represented in prefix notation:
- `Lf` represents a leaf node (null)
- `NODE <left> <value> <right>` represents an internal node with:
  - `<left>`: left subtree
  - `<value>`: the node's key
  - `<right>`: right subtree

Example:
```
        10
       /  \
      5   15
```

Is represented as: `NODE (Node Lf 5 Lf) 10 (Node Lf 15 Lf)`

## Implementation Details

### Files

- `tree.y`: Yacc grammar definition with semantic actions
- `tree.l`: Lex lexical analyzer definition
- `y.tab.c`, `y.tab.h`: Generated parser (from Bison)
- `lex.yy.c`: Generated lexer (from Flex)
- `TREE`: Compiled executable

### Key Functions

- `createNode()`: Create a single node
- `insertNode()`: Insert a value maintaining BST property
- `deleteNode()`: Remove a node and restructure the tree
- `countNodes()`: Count all nodes recursively
- `findKey()`: Search for a value in the tree
- `printTree()`: Output tree in prefix notation
- `checkBalanced()`: Verify perfect balance
- `getHeight()`: Calculate node height

## Notes

- The interpreter uses prefix notation for tree representation
- The `BALANCED` check verifies **perfect balance** (both subtrees must have exactly equal height)
- When inserting/deleting duplicate keys, the tree maintains standard BST behavior (duplicates ignored on insert)
- Memory is managed dynamically; the program allocates nodes as needed

## Exit

To exit the interpreter, press `Ctrl+D` (EOF) or `Ctrl+C`.

---

**Author**: Laboratory 7 - FLT (Formal Languages & Translators)  
**Language**: C with Yacc/Bison and Lex/Flex

