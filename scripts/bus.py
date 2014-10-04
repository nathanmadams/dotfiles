#!/usr/local/bin/python

import requests
from datetime import datetime
import time
from bs4 import BeautifulSoup
from optparse import OptionParser


class Bus(object):

    def __init__(self):
        self.line_count = 0
        self.complete = False

    def add_line(self, line):
        tokens = line.split(" ")
        if self.line_count == 0:
            self.bus_no = tokens[0]
            idx = 2
            if tokens[1] == "To":
                self.going_home = True
                idx += 1
            else:
                self.going_home = False
                if tokens[1] == "From":
                    idx += 1
            if tokens[idx] != "On":
                self.offset = int(tokens[idx])
                self.late = (tokens[idx+2] == "behind")
            else:
                self.offset = 0
                self.late = False
            self.line_count += 1
        elif self.line_count == 1:
            self.last_stop = line[2:]
            self.line_count += 1
        elif self.line_count == 2:
            arrive_time = tokens[-1]
            timeparts = arrive_time.split(":")
            self.scheduled_hour = int(timeparts[0])
            self.scheduled_minute = int(timeparts[1])
            self.hour = self.scheduled_hour
            if self.late:
                self.minute = self.scheduled_minute + self.offset
            else:
                self.minute = self.scheduled_minute - self.offset
            if (self.minute > 59):
                self.hour += 1
                self.minute -= 60
            self.next_stop = line[:-(len(arrive_time)+1)]
            self.complete = True

    def next_stop_mins(self):
        now = datetime.now()
        h = now.hour
        if (h > 12):
            h -= 12
        m = now.minute
        nowmins = h * 60 + m

        busmins = self.hour * 60 + self.minute
        return busmins - nowmins

parser = OptionParser()
parser.add_option('-p', '--poll',
                  action="store_true",
                  dest="poll",
                  default=False)

(options, args) = parser.parse_args()

poll = True
while poll:
    page = requests.get('http://mobile.theride.org/rideguide_m.asp?route=7')
    soup = BeautifulSoup(page.text)

    text = soup.findAll(text=True)

    insec = False
    buses = []
    bus = Bus()
    for line in text:
        if line == 'Information Key':
            insec = not insec
        elif insec:
            if not options.poll:
                print line
            if bus.complete:
                buses.append(bus)
                bus = Bus()
            bus.add_line(line)
    if not options.poll:
        print
    buses.append(bus)

    num_buses = 0
    for bus in buses:
        offset = -1
        if bus.going_home:
            if bus.next_stop == "Washtenaw and Pittsfield":
                offset = 10
            if bus.next_stop == "Stone School & Eisenhower":
                offset = 0
        if offset != -1:
            num_buses += 1
            print (
                "Bus {} will be here in {} minutes"
            ).format(bus.bus_no, bus.next_stop_mins() + offset)

    if num_buses < 1:
        print "No buses are coming soon"
    poll = options.poll
    if poll:
        time.sleep(20)

