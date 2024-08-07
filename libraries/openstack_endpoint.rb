
#
# Copyright:: 2016-2022, cloudbau GmbH
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

require_relative 'openstack_base'
module OpenstackclientCookbook
  class OpenstackEndpoint < OpenstackBase
    resource_name :openstack_endpoint
    provides :openstack_endpoint

    property :endpoint_name, String, name_property: true
    property :service_name, String, required: true
    property :interface, String, required: true
    property :url, String, required: true
    property :region, String
    property :connection_params, Hash, required: true

    default_action :create

    action :create do
      service = new_resource.connection.services.find { |s| s.name == new_resource.service_name }
      endpoint = new_resource.connection.endpoints.find do |e|
        e.service_id == service.id && e.interface == new_resource.interface
      end

      unless endpoint
        converge_by "creating endpoint #{new_resource.endpoint_name}" do
          new_resource.connection.endpoints.create(
            interface: new_resource.interface,
            url: new_resource.url,
            service_id: service.id,
            name: new_resource.endpoint_name,
            region: new_resource.region
          )
        end
      end
    end

    action :delete do
      service = new_resource.connection.services.find { |s| s.name == new_resource.service_name }
      endpoint = new_resource.connection.endpoints.find do |e|
        e.service_id == service.id && e.interface == new_resource.interface
      end
      if endpoint
        converge_by "deleting endpoint #{new_resource.endpoint_name}" do
          endpoint.destroy
        end
      end
    end
  end
end
