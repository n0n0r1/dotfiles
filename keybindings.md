# keybindings

## vscode

vimの設定で実現できないものを設定する

- ファイルアクセス
- 検索ウィジェット
- サイドバー

| key bindings | 内容            |
| ------------ | --------------- |
| CTRL-h       | previous editor |
| CTRL-l       | next editor     |
| CTRL-t       | open terminal   |
| CTRL-/       | search widget   |

### search widget

| key bindings | 内容                       |
| ------------ | -------------------------- |
| Enter        | close widget               |
| CTRL-l       | toggle find in selection   |
| CTRL-r       | toggle find regex          |
| CTRL-u       | toggle find case sensitive |
| CTRL-w       | toggle find whole word     |
| CTRL-/       | replace                    |

### sidebar

| key bindings | 内容 |
| ------------ | ---- |
| CTRL-q s     | toggle visibility    |

## vim normal mode

| key bindings | 内容                          |
| ------------ | ----------------------------- |
| CTRL-a       | increment number              |
| CTRL-j       | easy motion                   |
| CTRL-k       | easy motion                   |
| CTRL-x       | decrement number              |
| CTRL-w       | window                        |
| CTRL-/       | easy motion                   |
| LEADER-c     | create tab                    |
| LEADER-e     | ファイルオープン              |
| LEADER-f     | ファイル名検索                |
| LEADER-j     | insert line after             |
| LEADER-k     | insert line before            |
| LEADER-r     | open recent workspace or file |
| LEADER-t     | change file type              |
| LEADER-w     | save file                     |
| LEADER-q     | close file                    |

## vim insert mode

| key bindings          | 内容                                                             |
| --------------------- | ---------------------------------------------------------------- |
| CTRL-@                | 前回のinsert modeで入力した内容を再度入力し、insert modeを抜ける |
| CTRL-a                | 前回のinsert modeで入力した内容を再度入力                        |
| CTRL-b                | 割り当てなし                                                     |
| CTRL-c                | insert modeを抜ける                                              |
| CTRL-d                | インデントを1段階下げる(normal modeの<)                          |
| CTRL-e                | カーソルの下の文字を入力                                         |
| CTRL-h                | back space                                                       |
| CTRL-i                | tab                                                              |
| CTRL-j                | 改行                                                             |
| CTRL-m                | 改行                                                             |
| CTRL-n                | カーソル位置の単語でコードヒンティングを出す                     |
| CTRL-o                | 一度だけノーマルモードのコマンドを入力できる                     |
| CTRL-p                | カーソル位置の単語でコードヒンティングを出す                     |
| CTRL-q                | ターミナルに登録されていなければCTRL-Vと同じ                     |
| CTRL-r {0-9a-z"%#*:=} | レジスタに登録されている文字を貼り付け                           |
| CTRL-s                | 割り当てなし                                                     |
| CTRL-t                | インデントを1段階上げる(normal modeの>)                          |
| CTRL-u                | 行頭からカーソルの前までを削除                                   |
| CTRL-w                | カーソルの単語の先頭からカーソルの前までを削除                   |
| CTRL-y                | カーソルの上の単語を入力                                         |
| CTRL-[                | \<Esc>と同じ                                                     |

## vim visual mode
