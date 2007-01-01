#gutparse - utility for re-formatting Project Gutenberg ebook files so that
#extra line-breaks are removed.
#Copyright © 2006 Gifford Birchley
#
#This library is free software; you can redistribute it and/or
#modify it under the terms of the GNU Library General Public
#License as published by the Free Software Foundation; either
#version 2 of the License, or (at your option) any later version.
#
#This library is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#Library General Public License for more details.
#
#You should have received a copy of the GNU Library General Public
#License along with this library; if not, write to the Free
#Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#You can contact the author by email at gbirchley@hotmail.com.

#!/usr/local/bin/perl
use strict;

#VARIABLES:
my $temp = "temp.txt";
my $file;
my $confirm;
my $final = "final.txt";

print STDOUT "Enter a filename: ";
$file = <STDIN>;
chomp($file);

print STDOUT "You have selected $file.\n";
print STDOUT "Confirm? Y or N.\n";
$confirm = <STDIN>;

#User interface
SWITCH: {
  if($confirm =~ m/Y/) {
    print "You entered Y!";
  }
  if($confirm =~ m/N/) {
    print "You entered 'N' - please re-enter a filename: ";
    $file = <STDIN>;
  }
  if($confirm =~ m/Q/) {
    print "Program terminated."
  }
  if($confirm !~ m/Y|N|Q/) {
    print STDOUT "Please enter Y or N, or Q to quit.";
    $file = <STDIN>;
    if($file =~ m/Q/) {
      print "Program terminated."
      }
  }
}

#Text processing
if($confirm =~ m/Y/) {
open(TEXT, $file);
open(TEMP, ">$temp");
while (my $line = <TEXT>) {
  if ($line =~ m/.\n$/){    #Match redundant CR charcters (preceded by non-whitespace)
  $line =~ s/\n/ /;         #Replace with space
  print TEMP $line;
 }
  else {
  print TEMP $line;
  }
}
close(TEMP);
close(TEXT);

#Now replace CR where CR remains - for paragraph spacing
open(TEMP, $temp);
open(FINAL, ">$final");
while(my $line = <TEMP>) {
  if ($line =~ m/ \n/) {
    $line =~ s/ \n/\n\n/;
    print FINAL $line;
  }
}
close(FINAL);
close(TEMP);
unlink $temp;
print "Done!";
}

=head1 DESCRIPTION

A simple script to remove unnecessary line breaks in Project Gutenberg
eBook text files. This makes them easier to use in word processor and DTP
programs by allowing propoer text flow while preserving paragraph breaks
as a double CR.

=pod SCRIPT CATEGORIES

CPAN

=cut
