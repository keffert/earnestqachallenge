import os
import csv
import itertools
import sys
from robot.api import logger

class csvLibrary:

    ROBOT_LIBRARY_SCOPE = 'TEST SUITE'

    def __init__(self):
        pass
        # self.filename = filename

    def get_rows_from_csv_file(self, filename):
        '''Return an array of dictionaries found in filename.'''
        print 'Return an array of dictionaries found in filename %s.' % filename
        firstColumn = 'active'
        rowList = []
        f = open(filename, 'ra')
        dr = csv.DictReader(f, delimiter=',')
        print 'dictReader list:'
        print dr
        print ''
        for row in dr:
            # print 'all row string:'
            # for c in row.keys():
            # print str(c) + ': ' + str(row[c])

            # print ''
            if (row[firstColumn].find('#', 0, 2) < 0):
                # print 'non-commented row string:'
                # print str(c) + ': ' + str(row[c])

                # print ''
                rowList.append(row)

        return rowList

    def get_list_of_dicts_from_csv_file(self, filename):
        '''Return an array of dictionaries found in filename.'''
        return self.get_rows_from_csv_file(filename)

    def get_list_of_rows_from_csv_file(self, filename):
        '''Return an array of non-commented rows found in filename.'''
        return self.get_rows_from_csv_file(filename)

    def get_dict_from_csv_file_by_row(self, filename, rowNum):
        '''Return a dictionary found in a row in a filename.'''
        rows = self.get_rows_from_csv_file(filename)
        return rows[rowNum]

    def read_csv_file_return_dict(self, filename):
        return self.get_list_of_dicts_from_csv_file(filename)
    #    '''Return an array of dictionaries found in filename.'''
    #    data = []
    #    dictReader = csv.DictReader(open(filename, 'rb'), delimiter=',')
    #    for row in dictReader:
    #      data.append(row)
    #    return data

    def read_csv_file(self, filename):
        '''This creates a keyword named "Read CSV File"

        This keyword takes one argument, which is a path to a .csv file. It
        returns a list of rows, with each row being a list of the data in
        each column.
        '''
        return self.get_list_of_dicts_from_csv_file(filename)
    #    data = []
    #    with open(filename, 'rb') as csvfile:
    #      reader = csv.reader(csvfile)
    #      for row in reader:
    #        data.append(row)
    #    return data

    def read_excel_tab_delimitted_file(self, filename):
        ''' This keyword takes one argument, which is a path
    to .csv file. It returns a list of rows, with each row being a list of the data in each column. '''
        data = []
        with open(filename) as csvfile:
            reader = csv.reader(csvfile, dialect='excel', delimiter='\t')
            for row in reader:
                data.append(row)
        return data

    def lineCount(filename):
        with open(filename) as f:
            count = len(f.readlines())
        return count

    def getCellValue(self, filename, rowNum, colNum):
        with open(filename) as csvfile:
            rowNum= int(rowNum)
            colNum= int (colNum)
            row = next(itertools.islice(csv.reader(csvfile), rowNum, rowNum +1))
        return row[colNum]

    def getCellValueWithCol(self, filename, rowNum, colName):
        csvfile = open(filename)
        line = csvfile.readline().strip()
        rowNum = int(rowNum)
        colName = str(colName)
        row = next(itertools.islice(csv.reader(csvfile), rowNum, rowNum + 1))
        colNames = line.split(",")
        print colNames
        for i, word in enumerate(colNames):
            if word == colName:
                return row[i]


def main():
    csvlib = csvLibrary()
    data = csvlib.read_csv_file_return_dict('../../data/jungle_socks_orders.csv')
    for dct in data:
        for key, value in dct.iteritems():
            print key + ' : ' + value

if __name__ == '__main__':
    main()
