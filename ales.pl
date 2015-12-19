#!/usr/bin/perl
# Komut: ./ales.pl SANIYE

$num_args = $#ARGV + 1;
if ($num_args != 1) {
  print "\nUsage: ./ales.pl SANIYE\n";
  exit;
}

$interval = $ARGV[0];

while (1) {
	check();
	sleep($interval);
}

sub check {
	`wget "https://sonuc.osym.gov.tr/SonucSec.aspx" --quiet --no-check-certificate -O SONUC`;

	open $sonuc, "SONUC" or die "Valla açamadım: $!";

	while (<$sonuc>) {
		$line = $_;
		if ($line =~ /<a href="Sorgu.aspx\?SonucID.*(ALES)/) {
			print "!!!ALES AÇIKLANDI. GİT BAK HADİ!!!.\n";
			exit;
		}
	}
	print "Hala açıklanmamış. $interval saniye sonra bir daha gel!\n";
}
