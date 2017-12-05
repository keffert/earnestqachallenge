from os import path, sys
from robot.api import logger

class OrderTestData:

    ROBOT_LIBRARY_SCOPE = 'TEST SUITE'

    productPriceDict = {'zebra': '13', 'lion': '20', 'elephant': '35', 'giraffe': '17'}
    # print('price of zebra is ' + str(productPriceDict['zebra']))
    # print('price of lion is ' + str(productPriceDict['lion']))
    # print('price of elephant is ' + str(productPriceDict['elephant']))
    # print('price of giraffe is ' + str(productPriceDict['giraffe']))

    def __init__(self, orderTestDataDict=None):
        self.orderTestDataDict = orderTestDataDict

    def name(self):
        logger.info("Getting name...")
        return str(self.orderTestDataDict.get('name', ''))

    def price(self, name):
        logger.info("Getting price for " + self.name() + "...")
        return self.productPriceDict[self.name()]

    def inStock(self):
        logger.info("Getting in stock...")
        return self.orderTestDataDict.get('inStock', 0)

    def quantityOrdered(self):
        logger.info("Getting quantity ordered...")
        return self.orderTestDataDict.get('quantityOrdered', 0)

    def state(self):
        logger.info("Getting state...")
        return str(self.orderTestDataDict.get('state', ''))

    def orderSubtotal(self):
        logger.info("Getting order subtotal...")
        # print self.quantityOrdered()
        # print self.price(self.name())
        # print int(self.quantityOrdered()) * int(self.price(self.name()))
        return int(self.quantityOrdered()) * int(self.price(self.name()))

    def orderTotal(self):
        logger.info("Getting order total...")
        # print self.orderSubtotal()
        # print self.salesTaxByState(self.state())
        # print round(float(self.orderSubtotal()) + float(self.salesTaxByState(self.state())), 2)
        return round(float(self.orderSubtotal()) + float(self.salesTaxByState(self.state())), 2)

    def salesTaxPercent(self):
        logger.info("Getting sales tax percent...")
        if self.state() == 'NY':
            return 0.06
        elif self.state() == 'CA':
            return 0.08
        elif self.state() == 'MN':
            return 0.0

        return 0.05

    def salesTaxByState(self, state):
        logger.info("Getting sales tax...")
        return round(float(self.orderSubtotal()) * self.salesTaxPercent(), 2)

    def result(self):
        logger.info("Getting result...")
        return str(self.orderTestDataDict.get('result', ''))

    def active(self):
        logger.info("Getting active...")
        return str(self.orderTestDataDict.get('active', ''))

    def orderSubtotalString(self):
        logger.info("Getting order subtotal string...")
        return '$' + str(round(float(self.quantityOrdered()) * float(self.price()), 2))

    def setDict(self, orderTestDataDict):
        self.orderTestDataDict = orderTestDataDict
        return self

    def __repr__(self):
        result = str('\nactive:                       ' + str(self.active()))
        result = result + str('\nOrder:  ' + \
                              '\n  name:               ' + str(self.name()) +
                              '\n  inStock:            ' + str(self.inStock()) +
                              '\n  quantityOrdered:    ' + str(self.quantityOrdered()) +
                              '\n  state:              ' + str(self.state()) +
                              '\n  price:              ' + str(self.price(self.name())) +
                              '\n  orderSubtotal:      ' + str(self.orderSubtotal()) +
                              '\n  salesTaxPercent:    ' + str(self.salesTaxPercent()) +
                              '\n  salesTax:           ' + str(self.salesTaxByState(self.state())) +
                              '\n  orderTotal:         ' + str(self.orderTotal())
                              )

        return result

def main():
    otdd1 = {'active': '1', 'name': 'zebra', 'price': 13.00, 'inStock': 23, 'quantityOrdered': 12, 'state': 'NY'}

    otd1 = OrderTestData(otdd1)
    print otd1
    otd2 = otd1.setDict(otdd1)
    print otd2

if (__name__ == '__main__'):
    main()
