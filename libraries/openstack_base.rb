
#
# Copyright:: 2016-2022, cloudbau GmbH
# Copyright:: 2019-2022, Oregon State University
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

module OpenstackclientCookbook
  class OpenstackBase < Chef::Resource::LWRPBase
    require 'fog/openstack'
    def connection
      @connection_cache ||= Fog::OpenStack::Identity.new(connection_params)
    end
  end
end
