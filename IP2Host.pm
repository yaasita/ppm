#!/usr/bin/perl
package IP2Host;
use strict;
use feature ("say");

sub new{
	unless (-e "ip_host_list.txt") {
		open (WR,">ip_host_list.txt") or die "ip text create error!";
		close WR;
	}
	open (FH,"ip_host_list.txt") or die "host file not found!";
	my $class = shift;
	my ($ip,$host);
	my $self = {};

	while (<FH>){
		chomp $_;
		($ip,$host) = split (/::::/,$_);
		if ($ip eq undef or $host eq undef){
			die "ip_host_list.txt Format Error!";
		}
		$self->{$ip}=$host;
	}
	close FH;
	bless $self,$class;
}
sub ip2host{
	my $self    = shift;
	my $kensaku = shift;
	if( not $self->{$kensaku}){
		my $string=qx/nslookup $kensaku/;
		$self->{$kensaku}=
		$string=~/Name\:\s+(.*)$/m ? 
		$1 :
		$kensaku;
		return $self->{$kensaku};
	} 
	else {
		return $self->{$kensaku};
	}
}
sub DESTROY{
	my $self=shift;
	open (WR,">ip_host_list.txt") or die "Write File Error!";
	foreach (keys %{$self}){
		say WR $_."::::".$self->{$_};
	}
	close WR;
}
1;

__END__
=head1 NAME

IP2Host - IPアドレスからリモートホストをnslookupコマンドによって解決しファイルにキャッシュするモジュール 

=head1 SYNOPSIS

  use lib "S:/Program/ppm";                        #IP2Host.pmを置いたディレクトリ指定
  use IP2Host;

  my $obj=IP2Host->new;                    #コンストラクタ
  print $obj->ip2host("66.249.89.99");     #メソッドip2hostは引いた結果を返します 

=head1 DESCRIPTION

メソッドはip2hostのみですこれはnslookupの結果を返します。名前を引けなかった場合は
引数の値をそのまま返します。以下に例を示します。

 例)
 $obj->ip2host("124.83.139.192");  #yahooのリモートホストを返します
 $obj->ip2host("127.1.2.3.4");     #名前を引けなかったので"127.1.2.3.4"を返す
 $obj->ip2host("www.google.co.jp") #返答するDNSサーバーの名前を返します(ここではwww.l.google.com)

=head2 Attention

このモジュールは名前を引いたモジュールのキャッシュをするためにカレントディレクトリに
ip_host_list.txtを作成します。
オブジェクトが捨てられた時点でip_host_list.txtを更新します。
よってip2hostのオブジェクトを複数作成しないで下さい。

=head2 EXPORT

デフォルトで何もエクスポートしません

=head1 SEE ALSO

nslookupコマンドの返却値によって
ソースを変更しなければならないかもしれません。
このプログラムはWindowsXP + ActivePerlで動作確認済みですが、
それ以外は知りません。

=head1 AUTHOR

yamasita 

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by yamasita

=cut
