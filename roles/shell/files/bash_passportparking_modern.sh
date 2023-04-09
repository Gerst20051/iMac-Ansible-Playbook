# PassportParking Modern Utilities

# Fetch V2 Project Git Updates
function fetch_v2_updates {
    pwd=${PWD}
    repos=(
        # 'api-gateway-authorizer'
        # 'api-schema'
        # 'boilerplate-serverless-node6'
        'identity'
        # 'mpw-css-generator'
        'node-legacy-proxy'
        'node-serverless-authorizer'
        'node-serverless-database'
        'node-serverless-pagination'
        'node-serverless-request'
        'node-serverless-response'
        'node-serverless-router'
        'node-serverless-ssm-loader'
        'node-serverless-utils'
        'parking-serverless-authcodes'
        'parking-serverless-cards'
        'parking-serverless-jurisdictions'
        'parking-serverless-quotes'
        'parking-serverless-rates'
        'parking-serverless-sessions'
        # 'parking-serverless-spaces'
        'parking-serverless-users'
        # 'parking-serverless-validation'
        'parking-serverless-vehicles'
        'parking-serverless-zones'
        'pci-serverless-cards'
        # 's3-static-content'
    )
    dirty_repos=()
    echo 'Fetching Repos'
    for repo in "${repos[@]}"; do
        echo $repo
        # \cd ~/Web/PP/Projects/$repo && git fetch origin && { a=$(git branch -r | sed 's#origin/##g' | \grep -v '/\|HEAD'); echo "$a"; }
        \cd ~/Web/PP/Projects/$repo && git fetch origin && {
            if [[ `git status --porcelain` ]]; then
                dirty_repos+=($repo)
                echo Changes
            else
                branches=($(git branch -r | sed 's#origin/##g' | \grep -v '/\|HEAD'))
                for branch in "${branches[@]}"; do
                    current_branch=`git symbolic-ref --short -q HEAD`
                    if [ "$current_branch" == "$branch" ]; then
                        git reset --hard origin/$branch
                    else
                        git checkout $branch && git reset --hard origin/$branch
                    fi
                done
                if [[ " ${branches[@]} " =~ ' develop ' ]]; then
                    if [ "${branches[${#branches[@]} - 1]}" != 'develop' ]; then
                      git checkout develop
                    fi
                elif [[ " ${branches[@]} " =~ ' master ' ]]; then
                    if [ "${branches[${#branches[@]} - 1]}" != 'master' ]; then
                      git checkout master
                    fi
                else
                    echo "${branches[@]}"
                fi
            fi
        }
        sleep 1
    done
    if [ ${#dirty_repos[@]} -eq 0 ]; then
        echo 'No Dirty Repos'
    else
        echo "Dirty Repos: ${dirty_repos[@]}"
    fi
    cd ${pwd}
}
