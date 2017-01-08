#!/usr/bin/perl
package Today;
use strict;
use warnings;
our $VERSION = '1.00';
require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(yyyymmdd);


#時間計算
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime(time);
our $time=($year+1900).sprintf("%02d",$mon+1).sprintf("%02d",$mday);

sub yyyymmdd{
	return $time;
}

1;

__END__
=head1 NAME

Today - 現在の日付をYYYYMMDDで返すだけのモジュール
なんかいも同じロジック書くのめんどいから作った

=head1 SYNOPSIS

  use lib "S:/Program/ppm";                #Today.pmを置いたディレクトリ指定
  use Today qw(yyyymmdd);                  #デフォルトで何もロードしないのでここで指定

  print &yyyymmdd;

=head1 DESCRIPTION

上記の概要通りです

=head2 Attention

さあ

=head2 EXPORT

デフォルトで何もエクスポートしません

=head1 SEE ALSO

特になし

=head1 AUTHOR

yamasita 

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by yamasita

 著作権とかよく分からん

=cut
