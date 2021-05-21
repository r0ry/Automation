#! /bin/bash

echo "
 █████╗ ██╗   ██╗████████╗ ██████╗ ███╗   ███╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗████╗ ████║██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
███████║██║   ██║   ██║   ██║   ██║██╔████╔██║███████║   ██║   ██║██║   ██║██╔██╗ ██║
██╔══██║██║   ██║   ██║   ██║   ██║██║╚██╔╝██║██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
██║  ██║╚██████╔╝   ██║   ╚██████╔╝██║ ╚═╝ ██║██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
                                                                                     
███████╗ ██████╗██████╗ ██╗██████╗ ████████╗███████╗                                 
██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝██╔════╝                                 
███████╗██║     ██████╔╝██║██████╔╝   ██║   ███████╗                                 
╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   ╚════██║                                 
███████║╚██████╗██║  ██║██║██║        ██║   ███████║                                 
╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   ╚══════╝                                 
                                                                                     
"
read -p "Run update & upgrade? This may take a while (Y/N): " check
if [[ $check == "Y" || $check == "y" ]]
    then
        sudo apt -y update > /dev/null 2>&1
        sudo apt -y upgrade > /dev/null 2>&1
        echo "Installing curl"
        sudo apt -y install curl > /dev/null 2>&1
fi

echo "  1. Install ZSH"
echo "  2. Setup Oh-My-ZSH with themes and plugins"
echo "  3. Install Docker"
echo "  4. Install Kubernetes"
echo "  5. Setup Kubernetes users and services"
echo "  6. Install VS Code"
echo ""
echo ""
echo "Q to exit"
while true; do
    read -p "Input: " num
    case "$num" in
        1) 
            sudo apt -y install zsh
            ;;
        2)
            sudo apt -y install fzf
            chsh -s $(which zsh)
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
            cp zshrc ~/.zshrc
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/psprint/zsh-navigation-tools/master/doc/install.sh)"
            echo "Please logout for changes to take effect"
            ;;
        3)  
            sudo apt -y install apt-transport-https ca-certificates curl gnupg lsb-release
            sudo apt -y install docker.io
            sudo groupadd docker
            sudo usermod -aG docker $USER
            newgrp docker 
            echo "Installing portainer"
            docker volume create portainer_data
            docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
            ;;
        4) 
            sudo snap install microk8s --classic
            sudo usermod -a -G microk8s $USER
            sudo chown -f -R $USER ~/.kube
            echo "Please logout for changes to take effect"
            ;;
        5) 
            microk8s status --wait-ready
            microk8s enable dashboard dns ingress
            microk8s kubectl get all --all-namespaces
            microk8s dashboard-proxy
            ;;
        6)
            sudo snap install --classic code
            ;;
        q) 
            break;;
        Q)  
            break;;
    esac
done
