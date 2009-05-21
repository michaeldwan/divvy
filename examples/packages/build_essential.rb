package :apt_update do
  apply do
    run('aptitude -y update')
    run('aptitude -y safe-upgrade')
    run('aptitude -y full-upgrade')
  end
end

package :build_essential do
  requires :apt_update
  apply do
    apt %w(build-essential libssl-dev libreadline5-dev zlib1g-dev)
  end
end