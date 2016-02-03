#!/usr/bin/perl -w

use strict;
use diagnostics;

package Utility;
#-------------------------------------------------------------------
sub Parameter {
	my ($hostname,$datasource,$dbname,$username,$pass,$port);

	$hostname="tercel";
	$datasource="mysql";
	$dbname="service";
	$username="jelly";
	$pass="apoljelly";
	$port="3306";
	
	return ($hostname,$datasource,$dbname,$username,$pass,$port);
}

#-------------------------------------------------------------------
sub SysTime {
	my (@now);
	
	@now=localtime(time);
	$now[4]++;
	$now[5]+=1900;
	$now[3]=("0" x ($now[3] < 10)).$now[3];
	$now[4]=("0" x ($now[4] < 10)).$now[4];
	
	return (@now);
	#[0]sec(秒),[1]min(分),[2]hour(時),[3]day(日),[4]month(月),[5]year(年)
}

#-------------------------------------------------------------------
sub Space {
	my ($item,$count)=@_;
	
	return $item x $count;
}

#-------------------------------------------------------------------
sub CommaPors {	#Comma Process_將整數部份每三位加','
	my (@value)=@_;
	my ($integer,$decimal,$i,$j,$sign);
	
	for ($j=0; $j <= $#value; $j++) {
		if ($value[$j] !~ /[^0-9\.\-]/) {
			$sign=($value[$j] =~ /^[\+\-]/) ? substr($value[$j],0,1) : "";
			$value[$j]=~s/^[\+\-]//g;

			($integer,$decimal) = split /\./,$value[$j],2;
			$decimal=(!defined $decimal || ($decimal eq '')) ? '' : '.'.$decimal;
			$value[$j]='';
		
			for ($i=1; $i <= length $integer; $i++) {
				if (($i > 3) && (($i % 3) == 1)) {
					$value[$j]=substr($integer,-$i,1).",".$value[$j];
				} else {
					$value[$j]=substr($integer,-$i,1).$value[$j];
				}
			}
			$value[$j]=$sign.$value[$j].$decimal;
		}
	}
	
	return wantarray ? @value : $value[0];
}

1;
