import socket
import types

class NetLoginFile:

    def __index__(self):
        self.ip_prifix = "211.87"

    def getIP(self):
        local_ip = socket.gethostbyname(socket.gethostname())
        if self.ip_prifix in str(local_ip):
            return str(local_ip)
        ip_lists = socket.gethostbyname_ex(socket.gethostname())

        for ip_list in ip_lists:
            if isinstance(ip_list,list):
                for ip in ip_list:
                    if self.ip_prifix in str(ip):
                        return str(ip)
            elif type(ip_list) is types.StringType:
                if self.ip_prifix in str(ip_list):
                    return ip_list
