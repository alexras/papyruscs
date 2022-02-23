FROM debian:buster

RUN apt-get update && \
    apt-get install -y apt-transport-https && \
    apt-get update && \
    apt-get install -y wget

RUN wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb

RUN apt-get update && \
    apt-get install -y libgdiplus libc6-dev wget dotnet-sdk-3.1 dotnet-runtime-3.1

RUN mkdir -p /opt/papyruscs
COPY . /opt/papyruscs/

WORKDIR /opt/papyruscs

RUN dotnet publish PapyrusCs -c Debug --self-contained --runtime linux-x64

ENTRYPOINT ["/opt/papyruscs/PapyrusCs/bin/Debug/netcoreapp3.1/linux-x64/PapyrusCs"]
