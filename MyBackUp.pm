#!/usr/bin/perl
package MyBackUp;
use File::Copy ("copy");
use Archive::Zip;
use File::Basename;
use strict;
use warnings;
our $VERSION = '1.00';

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(zip_backup backup);


#時間計算
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime(time);
our $time=($year+1900).sprintf("%02d",$mon+1).sprintf("%02d",$mday);

sub backup{
	my $source=shift;
	my $target=shift;
	$source=~s/\//\\/;
	$target=~s/\//\\/;
	if ($target=~/\.\w+$/){
		$target=~s/\.(\w+)$/_${time}\.$1/;
	}
	else{
		$target.="_${time}";
	}
	copy $source,$target or die $!;
}
sub zip_backup{
	my $source=shift;
	my $target=shift;
	$source=~s/\//\\/;
	$target=~s/\//\\/;

	#末尾の\を削除
	$source=~s/\\$//;
	$target=~s/\\$//;

	$target.="_$time";
	system "xcopy /E /I /Y \"$source\" \"$target\"" and die $!;
	chdir dirname($target) or die $!;

	my $zip=Archive::Zip->new() or die $!;
	$zip->addTree(basename($target),basename($target));
	$zip->writeToFileNamed(basename($target).".zip");
	system "rmdir /S /Q ".(basename($target)) and die $!;
}


1;

__END__
=head1 NAME

MyBackUp - 現在の時間を付けつつ、バックアップを行うその際zip圧縮もできる

=head1 SYNOPSIS

  use lib "S:/Program/ppm";                #MyBackUp.pmを置いたディレクトリ指定
  use MyBackUp qw(backup,zip_backup);      #デフォルトで何もロードしないのでここで指定

  #単一ファイルは↓のようにして使うlife.txtではなくlife_YYYYMMDD.txtとしてバックアップされる
  backup("C:/life.txt","C:/BACKUP_DIR/life.txt");

  #ディレクトリは以下のように使う
  #保存形式はProgram_YYYYMMDD.zip
  #第二引数にはディレクトリを指定すること
  zip_backup("C:/Program","C:/BACKUP_DIR/Program");

=head1 DESCRIPTION

上記の概要通りです

=head2 Attention

Windows専用です
引数は絶対パスを指定して下さい

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
