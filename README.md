# Squid_proxy
This is a beginner's guide for the installation and administration of the SQUID proxy server. 
We show how to install the service both by source code and package installer (in this case we use yum since the tests were done from the CentOS operating system).
Among all the options provided by the service, we also show three specific scenarios with some of Squid's operating modes, such as reverse mode and transparent mode. 
The project includes a pdf as a guide to all the theoretical part of the service (what is a proxy, operating proxy modes, protocols...) 
and all the steps and explanations to run the installation and administration of the service (installation modes, setting up the scenarios, Squid configuration files...). 
The guide also documents the results of each scenario, both from the logs of the service itself and with the Wireshark results.
There are several scripts in order to make easier the instalation and testing of the scenarios.
The scenarios were initially set up with virtual machines and then tested in a real environment with different machines performing their function. 
Services such as Apache, DHCP, iptables can be used for some scenarios.

The rest of the project is written in spanish. Hope it helps someone!
