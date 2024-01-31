FROM oraclelinux:7


RUN groupadd dba && useradd -m -G dba oracle && mkdir /u01 && chown oracle:dba /u01
# RUN yum -y update
RUN yum -y install oracle-rdbms-server-11gR2-preinstall glibc-static wget unzip
RUN yum clean all

ADD install /install
ADD database /oracle_install/database
# ADD db2 /oracle_install

RUN chown -R oracle:dba /oracle_install
# RUN ls -l /
# RUN ls -l /oracle_install

RUN /install/oracle_install.sh


ENV DBCA_TOTAL_MEMORY=4096
ENV WEB_CONSOLE=false
ENV ORACLE_SID=EE
ENV ORACLE_HOME=/u01/app/oracle/product/11.2.0/EE
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/u01/app/oracle/product/11.2.0/EE/bin

ADD entrypoint.sh /entrypoint.sh

EXPOSE 1521

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
