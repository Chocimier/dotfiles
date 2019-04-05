#!/usr/bin/env python3
from calendar import Calendar, monthrange, day_abbr
import datetime
import locale

locale.setlocale(locale.LC_ALL, '')

class Cal:
    distinguish_prefix = ''
    distinguish_suffix = ''
    _distinguished_day = None

    @property
    def distinguished_day(self):
        return self._distinguished_day

    @distinguished_day.setter
    def distinguished_day(self, day):
        self._distinguished_day = datetime.date(day.year, day.month, day.day)

    def _table_of_month(self, date):
        header = date.strftime('%OB %Y')
        table = '{:^20} \n'.format(header)
        for i in range(7):
            table += '{:>2} '.format(day_abbr[i%7][:2])
        table += '\n'
        table += self._days_table(date.year, date.month)
        return table

    def _days_table(self, year, month):
        calendar = Calendar()
        table = ''
        for idx, day in enumerate(calendar.itermonthdates(year, month)):
            if day.month == month:
                if day == self.distinguished_day:
                    string = self.distinguish_prefix + '{:>2}'.format(str(day.day)) + self.distinguish_suffix
                else:
                    string = str(day.day)
            else:
                string = ''
            table += '{:>2} '.format(string)
            if idx % 7 == 6:
                table += '\n'
        return table.strip("\n")

    def _days_in_month(self, year, month):
        return monthrange(year, month)[1]

    def _add_months(self, date, count):
        newmonth = date.month + count
        newmonth -= 1
        newyear = date.year + newmonth // 12
        newmonth %= 12
        newmonth += 1
        newday = min(date.day, self._days_in_month(newyear, newmonth))
        return datetime.date(newyear, newmonth, newday)

    def _join_tables(self, tables):
        part_tables = [t.split('\n') for t in tables]
        table_height = len(max(part_tables, key=len))
        table = ['' for i in range(table_height)]
        for part_table in part_tables:
            for i in range(table_height):
                if i < len(part_table):
                    table[i] += part_table[i] + ' '
                else:
                    table[i] += (len(part_table[0]) + 1) * ' '
        return '\n'.join(table)

    def draw_months(self, count):
        return self._join_tables(self._table_of_month(self._add_months(self.distinguished_day, i)) for i in range(count))

if __name__ == '__main__':
    cal = Cal()
    cal.distinguished_day = datetime.datetime.today()
    cal.distinguish_prefix = '${outlinecolor #000}${color #fff}'
    cal.distinguish_suffix = '$color$outlinecolor'
    print(cal.draw_months(2))
