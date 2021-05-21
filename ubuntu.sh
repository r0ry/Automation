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
echo "Running update & upgrade. This may take a while"
sudo apt -y update > /dev/null 2>&1
sudo apt -y upgrade > /dev/null 2>&1
echo "Installing curl"
sudo apt -y install curl > /dev/null 2>&1

echo "  1. Oh-My-ZSH"
echo "  2. Setup ZSH themes and plugins"
echo "  3. Docker"
echo "  4. Kubernetes"
echo "  5. VS Code"
echo ""
echo ""
echo "  6. All"
echo "  Q to exit"
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
            cp -i zshrc ~/.zshrc
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/psprint/zsh-navigation-tools/master/doc/install.sh)"
            ;;
        3)  
            sudo apt-get -y install apt-transport-https ca-certificates curl gnupg lsb-release
            sudo groupadd docker
            sudo usermod -aG docker $USER
            newgrp docker 
            ;;
        4) 
            sudo snap install microk8s --classic
            sudo usermod -a -G microk8s $USER
            sudo chown -f -R $USER ~/.kube
            su - $USER
            microk8s status --wait-ready
            microk8s enable dashboard dns ingress
            microk8s kubectl get all --all-namespaces
            microk8s dashboard-proxy
            ;;
        5)
            sudo snap install --classic code
            ;;
        q) 
            break;;
        Q)  
            break;;
    esac
done
