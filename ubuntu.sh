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
echo "Running update"
sudo apt update 

echo "  1. Oh-My-ZSH"
echo "  2. Docker"
echo "  3. Kubernetes"
echo "  4. VS Code"
echo ""
echo ""
echo "  5. All"
while true; do
    read -p "Input: " num
    case "$num" in
        1) 
            sudo apt install zsh
            sudo apt install fzf
            chsh -s $(which zsh)
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
            cp -i zshrc ~/.zshrc
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/psprint/zsh-navigation-tools/master/doc/install.sh)"
            ;;
        2)  
            sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
            sudo groupadd docker
            sudo usermod -aG docker $USER
            newgrp docker 
            ;;
        3) 
            sudo snap install microk8s --classic
            sudo usermod -a -G microk8s $USER
            sudo chown -f -R $USER ~/.kube
            newgrp microk8s
            microk8s status --wait-ready
            microk8s enable dashboard dns ingress
            microk8s kubectl get all --all-namespaces
            microk8s dashboard-proxy
            ;;
        4)
            sudo snap install --classic code

    esac
done