#!/bin/sh

# EU CPOC Base URL :    https://cpoc.jrc.ec.europa.eu/L0
# CCMS.PT BAse URL:     https://0.dc.pilot.croads.ccms.pt/L0


mkdir -p /mnt/rw/ccms.pt

wget https://cpoc.jrc.ec.europa.eu/L0/gettlmcertificate -O /mnt/rw/ccms.pt/tlm
wget https://cpoc.jrc.ec.europa.eu/L0/gettlmlinkcertificate -O /mnt/rw/ccms.pt/tlmlink
wget https://cpoc.jrc.ec.europa.eu/L0/getectl/1D261F9E338ECB5B -O /mnt/rw/ccms.pt/ectl

wget http://0.dc.pilot.croads.ccms.pt/L0/getcert -O /mnt/rw/ccms.pt/rca
wget http://0.dc.pilot.croads.ccms.pt/L0/getctl -O /mnt/rw/ccms.pt/ctl
wget http://0.dc.pilot.croads.ccms.pt/L0/getcrl -O /mnt/rw/ccms.pt/crl


cd /mnt/rw/exampleETSI

certadm add /mnt/rw/ccms.pt/rca
certadm add-ctl -ourCtl /mnt/rw/ccms.pt/ctl
crladm import --etsiCrl /mnt/rw/ccms.pt/crl



# “rsu.conf”:
#- disable security check in the .conf file
#  Cohda_Crypto_InitSelfTest = 0
#- aerolink logging can be enabled with 
#  Cohda_Crypto_AeroLogging = all
#- configure the TLS certificate
#  SCMS_SSLCAFile = /etc/ssl/certs/DST_Root_CA_X3.pem


#“rsu.cfg”:
#For IVIM (In Vehicle Information Message) the permissions for the ServiceProviderCountryID and ServiceProviderIssuerId need to be adapted.
#- ServiceProviderCountryID default 0x31C is for Australia
#- ServiceProviderIssuerId default is 1
#For details of the ServiceProviderCountryID and ServiceProviderIssuerId encoding see Appendix 4.1



# "aerolink/active/security-context/its.wsc":