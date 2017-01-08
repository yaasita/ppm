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


#���Ԍv�Z
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

	#������\���폜
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

MyBackUp - ���݂̎��Ԃ�t���A�o�b�N�A�b�v���s�����̍�zip���k���ł���

=head1 SYNOPSIS

  use lib "S:/Program/ppm";                #MyBackUp.pm��u�����f�B���N�g���w��
  use MyBackUp qw(backup,zip_backup);      #�f�t�H���g�ŉ������[�h���Ȃ��̂ł����Ŏw��

  #�P��t�@�C���́��̂悤�ɂ��Ďg��life.txt�ł͂Ȃ�life_YYYYMMDD.txt�Ƃ��ăo�b�N�A�b�v�����
  backup("C:/life.txt","C:/BACKUP_DIR/life.txt");

  #�f�B���N�g���͈ȉ��̂悤�Ɏg��
  #�ۑ��`����Program_YYYYMMDD.zip
  #�������ɂ̓f�B���N�g�����w�肷�邱��
  zip_backup("C:/Program","C:/BACKUP_DIR/Program");

=head1 DESCRIPTION

��L�̊T�v�ʂ�ł�

=head2 Attention

Windows��p�ł�
�����͐�΃p�X���w�肵�ĉ�����

=head2 EXPORT

�f�t�H���g�ŉ����G�N�X�|�[�g���܂���

=head1 SEE ALSO

���ɂȂ�

=head1 AUTHOR

yamasita 

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2009 by yamasita

 ���쌠�Ƃ��悭�������

=cut
