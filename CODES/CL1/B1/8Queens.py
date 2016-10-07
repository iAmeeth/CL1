import sys
import numpy as np
from xml.dom import minidom
xmldoc = minidom.parse('data.xml')
itemlist = xmldoc.getElementsByTagName('Item')
# override default recursion limit
sys.setrecursionlimit(1000000000)

firstQueen=0
class NQueens:

    def __init__(self, size_of_board):
        self.size = size_of_board
        self.columns = [] * self.size
        self.num_of_places = 0
        self.num_of_backtracks = 0
        
    def placeFirst(self):
        self.columns.append(firstQueen)
        
    def place(self,startRow=0):
        """ Backtracking algorithm to recursively place queens on the board
            args:
                startRow: the row which it attempts to begin placing the queen
            returns:
                list representing a solution
        """
        #self.columns.append(firstQueen)
        # if every column has a queen, we have a solution
        if len(self.columns) == self.size:
            print('Solution found! The board size was: ' + str(self.size))
            print(str(self.num_of_places) + ' total places were made.')
            print(str(self.num_of_backtracks) + ' total backtracks were executed.')
            print(self.columns)
            return self.columns
        
        
                # otherwise search for a safe queen location
        else:
            for row in range(startRow, self.size):
                # if a safe location in this column exists
                if self.isSafe(len(self.columns), row) is True:
                    # place a queen at the location
                    self.columns.append(row)
                    self.num_of_places += 1
                    # recursively call place() on the next column
                    return self.place()

                # if not possible, reset to last state and try to place queen
            else:
                # grab the last row to backtrack from
                lastRow = self.columns.pop()
                self.num_of_backtracks += 1
                # recursively call place() from the last known good position, incrementing to the next row
                return self.place(startRow=lastRow + 1)

    def isSafe(self, col, row):
        """Determines if a move is safe.
        args:
            col: column of desired placement
            row: row of desired placement
            self.columns: list of queens presently on the board
        returns:
            True if safe, False otherwise
        """
        # check for threats from each queen currently on board
        for threatRow in self.columns:
            # for readability
            threatCol = self.columns.index(threatRow)
            # check for horizontal/vertical threats
            if row == threatRow or col == self.columns.index(threatRow):
                return False
            # check for diagonal threats
            elif threatRow + threatCol == row + col or threatRow - threatCol == row - col:
                return False
        # if we got here, no threats are present and it's safe to place the queen at the (col, row)
        return True

# set the size of the board
n = 8
# instantiate the board and call the backtracking algorithm
dataList = []
for s in itemlist:
    dataList.append(s.getAttribute("index").encode("utf-8"))
print dataList


for s in dataList:

    if(s!=' '):
        firstQueen=int(s)
        break
        
print "First queen placed in first row at: ",firstQueen
queens = NQueens(8)
queens.placeFirst()
queens.place(0)

# convert board to numpy array for pretty printing
board = np.array([['*'] * n] * n)
for queen in queens.columns:
    board[queens.columns.index(queen), queen] = 'Q'

print board
