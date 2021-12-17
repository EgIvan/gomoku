class Game:
    def __init__(self):
        self.board = [[0] * 17 for i in range(17)]
        self.color = 1
        self.winx1 = 0
        self.winx2 = 0
        self.winy1 = 0
        self.winy2 = 0

    def turn(self):
        if self.color % 2 == 1:
            return True
        else:
            return False

    def check(self, x, y):
        if self.board[y][x] != 0:
            return False
        return True

    def b_or_w(self, x, y):
        if self.board[y][x] == 'b':
            return True
        else:
            return False

    def move(self, x, y):
        if self.check(x, y):
            if self.turn():
                self.board[y][x] = 'b'
            else:
                self.board[y][x] = 'w'
            self.color += 1
        return

    def win_h(self, x, y):
        m = -1
        c = 0
        for i in self.board[y]:
            m += 1
            if self.turn():
                if i == 'w':
                    c += 1
                else:
                    k = c
                    c = 0
                    if k == 5:
                        self.winx1 = y
                        self.winy1 = m - 1
                        self.winx2 = y
                        self.winy2 = m - 5
                        return True
            else:
                if i == 'b':
                    c += 1
                else:
                    k = c
                    c = 0
                    if k == 5:
                        self.winx1 = y
                        self.winy1 = m - 1
                        self.winx2 = y
                        self.winy2 = m - 5
                        return True
        return False

    def win_v(self, x, y):
        c = 0
        m = -1
        for i in range(15):
            m  += 1
            if self.turn():
                if self.board[i][x] == 'w':
                    c += 1
                else:
                    k = c
                    c = 0
                    if k == 5:
                        self.winx1 = m - 1
                        self.winy1 = x
                        self.winx2 = m - 5
                        self.winy2 = x
                        return True
            else:
                if self.board[i][x] == 'b':
                    c += 1
                else:
                    k = c
                    c = 0
                    if k == 5:
                        self.winx1 = m - 1
                        self.winy1 = x
                        self.winx2 = m - 5
                        self.winy2 = x
                        return True
        return False

    def win_d1(self, x, y):
        c = 0
        n = min(x,y)
        x -= n
        y -= n
        while (x < 15) and (y < 15):
            if self.turn():
                if self.board[y][x] == 'w':
                    c += 1
                else:
                    k = c
                    c = 0
                    if k == 5:
                        self.winx1 = y - 1
                        self.winy1 = x - 1
                        self.winx2 = y - 5
                        self.winy2 = x - 5
                        return True
            else:
                if self.board[y][x] == 'b':
                    c += 1
                else:
                    k = c
                    c = 0
                    if k == 5:
                        self.winx1 = y - 1
                        self.winy1 = x - 1
                        self.winx2 = y - 5
                        self.winy2 = x - 5
                        return True
            x += 1
            y += 1
        return False

    def win_d2(self, x, y):
        p = x + 1
        q = y - 1
        c = 0
        o = 0
        n = 0
        while (x >= 0) and (y < 15):
            if self.turn():
                if self.board[y][x] == 'w':
                    c += 1
                else:
                    if o == 0:
                        n = c
                        o = 1
                    k = c
                    c = 0
                    if k == 5:
                        self.winx1 = y - 1
                        self.winy1 = x + 1
                        self.winx2 = y - 5
                        self.winy2 = x + 5
                        return True
            else:
                if self.board[y][x] == 'b':
                    c += 1
                else:
                    if o == 0:
                        n = c
                        o = 1
                    k = c
                    c = 0
                    if k == 5:
                        self.winx1 = y - 1
                        self.winy1 = x + 1
                        self.winx2 = y - 5
                        self.winy2 = x + 5
                        return True
            x -= 1
            y += 1
        c = n
        while (p < 15) and (q >= 0):
            if self.turn():
                if self.board[q][p] == 'w':
                    c += 1
                else:
                    k = c
                    c = 0
                    if k == 5:
                        self.winx1 = q + 1
                        self.winy1 = p - 1
                        self.winx2 = q + 5
                        self.winy2 = p - 5
                        return True
            else:
                if self.board[q][p] == 'b':
                    c += 1
                else:
                    k = c
                    c = 0
                    if k == 5:
                        self.winx1 = q + 1
                        self.winy1 = p - 1
                        self.winx2 = q + 5
                        self.winy2 = p - 5
                        return True
            p += 1
            q -= 1
        return False

    def win(self, x, y):
        if (self.win_h(x, y)) or (self.win_v(x, y)) or (self.win_d1(x,y)) or (self.win_d2(x,y)):
            return True
        return False

    def win_x1(self):
        return self.winx1

    def win_x2(self):
        return self.winx2

    def win_y1(self):
        return self.winy1

    def win_y2(self):
        return self.winy2


from tkinter import *

root = Tk()
root.title('gomoku')

canvas = Canvas(root, width = 400, height = 400)
canvas.grid()

canvas.create_rectangle(0, 0, 400, 400, fill = 'LightSalmon4')

y1 = 25
y2 = 25
while y1 <= 375:
    x1 = 25
    x2 = 375
    canvas.create_line(x1, y1, x2, y2)
    y1 += 25
    y2 += 25

x1 = 25
x2 = 25
while x1 <= 375:
    y1 = 25
    y2 = 375
    canvas.create_line(x1, y1, x2, y2)
    x1 += 25
    x2 += 25

g = Game()

def off_click(event):
    global g
    g = Game()

    canvas.create_rectangle(0, 0, 400, 400, fill='LightSalmon4')
    y1 = 25
    y2 = 25
    while y1 <= 375:
        x1 = 25
        x2 = 375
        canvas.create_line(x1, y1, x2, y2)
        y1 += 25
        y2 += 25

    x1 = 25
    x2 = 25
    while x1 <= 375:
        y1 = 25
        y2 = 375
        canvas.create_line(x1, y1, x2, y2)
        x1 += 25
        x2 += 25
    canvas.bind('<Button>', on_click)

def on_click(event):
    v = 25
    while v < 376:
        w = 25
        while w < 376:
            if (v - 11 < event.y < v + 11) and (w - 11 < event.x < w + 11):
                g.move(w // 25, v // 25)
                if g.b_or_w(w // 25, v // 25):
                    canvas.create_oval(w - 11, v - 11, w + 11, v + 11, fill = 'black')
                else:
                    canvas.create_oval(w - 11, v - 11, w + 11, v + 11, fill = 'white', outline = 'white')
                if g.win(w//25,v//25):
                    canvas.create_line(g.win_y1()*25, g.win_x1()*25,
                                       g.win_y2()*25, g.win_x2()*25, fill = 'green2', width = 3)
                    canvas.bind('<Button>', off_click)
            w += 25
        v += 25

canvas.bind('<Button>', on_click)

root.mainloop()
