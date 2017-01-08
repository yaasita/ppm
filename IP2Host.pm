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

IP2Host - IP�A�h���X���烊���[�g�z�X�g��nslookup�R�}���h�ɂ���ĉ������t�@�C���ɃL���b�V�����郂�W���[�� 

=head1 SYNOPSIS

  use lib "S:/Program/ppm";                        #IP2Host.pm��u�����f�B���N�g���w��
  use IP2Host;

  my $obj=IP2Host->new;                    #�R���X�g���N�^
  print $obj->ip2host("66.249.89.99");     #���\�b�hip2host�͈��������ʂ�Ԃ��܂� 

=head1 DESCRIPTION

���\�b�h��ip2host�݂̂ł������nslookup�̌��ʂ�Ԃ��܂��B���O�������Ȃ������ꍇ��
�����̒l�����̂܂ܕԂ��܂��B�ȉ��ɗ�������܂��B

 ��)
 $obj->ip2host("124.83.139.192");  #yahoo�̃����[�g�z�X�g��Ԃ��܂�
 $obj->ip2host("127.1.2.3.4");     #���O�������Ȃ������̂�"127.1.2.3.4"��Ԃ�
 $obj->ip2host("www.google.co.jp") #�ԓ�����DNS�T�[�o�[�̖��O��Ԃ��܂�(�����ł�www.l.google.com)

=head2 Attention

���̃��W���[���͖��O�����������W���[���̃L���b�V�������邽�߂ɃJ�����g�f�B���N�g����
ip_host_list.txt���쐬���܂��B
�I�u�W�F�N�g���̂Ă�ꂽ���_��ip_host_list.txt���X�V���܂��B
�����ip2host�̃I�u�W�F�N�g�𕡐��쐬���Ȃ��ŉ������B

=head2 EXPORT

�f�t�H���g�ŉ����G�N�X�|�[�g���܂���

=head1 SEE ALSO

nslookup�R�}���h�̕ԋp�l�ɂ����
�\�[�X��ύX���Ȃ���΂Ȃ�Ȃ���������܂���B
���̃v���O������WindowsXP + ActivePerl�œ���m�F�ς݂ł����A
����ȊO�͒m��܂���B

=head1 AUTHOR

yamasita 

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 by yamasita

=cut
