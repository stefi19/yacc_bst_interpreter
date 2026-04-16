%{
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
typedef struct _node {
    int key;
    struct _node *left;
    struct _node *right;
} node;
//prototypes of functions
node *createNode(int key, node *left, node *right);
node *insertNode(int key, node *root);
int countNodes(node *root);
void printTree(node *root);
void prettyPrintTree(node *root, int depth);
void printBool(bool value);
bool findKey(int key, node *root);
int yylex(void);
void yyerror(const char *s){ fprintf(stderr,"Error: %s\n",s); }
%}

%union {
    int ival;
    struct _node *btree;
}

%token <ival> NUMBER
%token NODE COUNT INSERT LF FIND

%type <ival> i_expr
%type <btree> t_expr tree
%type <ival> b_expr

%%
file: file expr '\n'
    | file '\n'
    |
    ;
expr: i_expr {printf("%d\n",$1);}
    | t_expr {printTree($1); printf("\n");}
    | b_expr {printBool($1); printf("\n");}
    ;
i_expr: COUNT t_expr {$$ = countNodes($2);}
    | '(' i_expr ')' {$$ = $2;}
    | NUMBER
    ;
t_expr: INSERT i_expr t_expr {$$ = insertNode($2, $3);}
    | '(' t_expr ')' {$$ = $2;}
    | tree
    ;
b_expr: FIND i_expr t_expr {$$ = findKey($2, $3);}
    | '(' b_expr ')' {$$ = $2;}
    | tree {$$ = ($1 != NULL);}
    ;
tree: NODE tree NUMBER tree {$$ = createNode($3, $2, $4);}
    | '(' tree ')' {$$ = $2;}
    | LF {$$ = NULL;}
    ;
%%

node *createNode(int key, node *left, node *right) {
    node *newNode = malloc(sizeof(node));
    newNode->key = key;
    newNode->left = left;
    newNode->right = right;
    return newNode;
}

node *insertNode(int key, node *root) {
    if (root == NULL) {
        return createNode(key, NULL, NULL);
    }
    if (key < root->key) {
        root->left = insertNode(key, root->left);
    } else if (key > root->key) {
        root->right = insertNode(key, root->right);
    }
    return root;
}
int countNodes(node *root) {
    if (root == NULL) {
        return 0;
    }
    return 1 + countNodes(root->left) + countNodes(root->right);
}
void printTree(node *root) {
    if (root == NULL) {
        printf("LF ");
        return;
    }
    printf("NODE ");
    printTree(root->left);
    printf("%d ", root->key);
    printTree(root->right);
}

void prettyPrintTree(node *root, int depth) {
    if (root == NULL) {
        return;
    }
    prettyPrintTree(root->right, depth + 1);
    for (int i = 0; i < depth; i++) {
        printf("    ");
    }
    printf("%d\n", root->key);
    prettyPrintTree(root->left, depth + 1);
}

void printBool(bool value) {
    if(value) {
        printf("Found");
    } else {
        printf("Not Found");
    }
}

bool findKey(int key, node *root) {
    if (root == NULL) {
        return false;
    }
    if (key == root->key) {
        return true;
    }
    if (key < root->key) {
        return findKey(key, root->left);
    } else {
        return findKey(key, root->right);
    }
}